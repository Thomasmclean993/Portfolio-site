#!/usr/bin/env ruby
# generate_tags_from_posts.rb
# Scans Jekyll posts for tags, cross-references with _data/tags.yml,
# and generates missing /tags/{tag}.md pages that use your tag.html layout.
# Compatible with GitHub Pages safe mode.

require 'yaml'
require 'fileutils'
require 'date'

ROOT       = __dir__
DATA_FILE  = File.join(ROOT, '_data', 'tags.yml')
POSTS_DIR  = File.join(ROOT, '_posts')
TAGS_DIR   = File.join(ROOT, 'tag')

# Ensure /tags directory exists
FileUtils.mkdir_p(TAGS_DIR)

# Load tag metadata from _data/tags.yml if it exists
tag_metadata = if File.exist?(DATA_FILE)
  YAML.load_file(DATA_FILE)
else
  {}
end

found_tags = []

# Scan all posts recursively in _posts/
Dir.glob(File.join(POSTS_DIR, '**', '*.*')).each do |post_path|
  next unless File.file?(post_path)

  content = File.read(post_path)

  # Extract YAML front matter between the first pair of ---
  if content =~ /\A---\s*\n(.*?)\n---\s*\n/m
    begin
      # Allow Time and Date objects in the front matter
      front_matter = YAML.safe_load(
        $1,
        permitted_classes: [Time, Date],
        aliases: true
      )

      if front_matter.is_a?(Hash) && front_matter['tags']
        found_tags.concat(Array(front_matter['tags']))
      end

    rescue Psych::Exception => e
      warn "YAML parse error in #{post_path}: #{e.message}"
    end
  end
end

found_tags.uniq.sort.each do |tag_key|
  meta      = tag_metadata[tag_key] || {}
  title     = meta['name'] || tag_key.capitalize
  permalink = "/tag/#{tag_key}/"

  file_path = File.join(TAGS_DIR, "#{tag_key}.md")

  # Only create if it doesn't already exist to avoid overwriting customization
  unless File.exist?(file_path)
    front_matter = <<~FRONT
      ---
      # AUTO-GENERATED FILE — DO NOT EDIT BY HAND
      layout: tag
      tag: #{tag_key}
      title: "#{title}"
      permalink: #{permalink}
      ---
    FRONT

    File.write(file_path, front_matter)
    puts "Generated #{file_path}"
  else
    puts "Skipped #{file_path} (already exists)"
  end
end

puts "Done! Total unique tags found: #{found_tags.uniq.size}"
