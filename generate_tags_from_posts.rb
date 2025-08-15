#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'
require 'date'

ROOT       = __dir__
DATA_FILE  = File.join(ROOT, '_data', 'tags.yml')
POSTS_DIR  = File.join(ROOT, '_posts')
TAGS_DIR   = File.join(ROOT, 'tag')

# -------------------------------
# 1. Clean /tag folder to avoid duplicates
# -------------------------------
if Dir.exist?(TAGS_DIR)
  puts "Cleaning existing #{TAGS_DIR} directory..."
  FileUtils.rm_rf(TAGS_DIR)
end
FileUtils.mkdir_p(TAGS_DIR)

# -------------------------------
# 2. Load _data/tags.yml if it exists
# -------------------------------
tag_metadata = File.exist?(DATA_FILE) ? YAML.load_file(DATA_FILE) : {}

# -------------------------------
# 3. Scan _posts for tags
# -------------------------------
found_tags = []

Dir.glob(File.join(POSTS_DIR, '**', '*.{md,markdown,html}')).each do |post_path|
  content = File.read(post_path)
  if content =~ /\A---\s*\n(.*?)\n---\s*\n/m
    begin
      fm = YAML.safe_load($1, permitted_classes: [Time, Date], aliases: true)
      if fm.is_a?(Hash) && fm['tags']
        found_tags.concat(Array(fm['tags']).map { |t| t.to_s.strip.downcase })
      end
    rescue Psych::Exception => e
      warn "YAML parse error in #{post_path}: #{e.message}"
    end
  end
end

found_tags.uniq.sort.each do |tag_key|
  meta  = tag_metadata[tag_key] || {}
  title = meta['name'] || tag_key.capitalize
  permalink = "/tag/#{tag_key}/"

  file_path = File.join(TAGS_DIR, "#{tag_key}.md")

  front_matter = <<~FRONT
    ---
    layout: tag
    tag: #{tag_key}
    title: "#{title}"
    permalink: #{permalink}
    ---
  FRONT

  File.write(file_path, front_matter)
  puts "Generated tag page: #{file_path}"
end

puts "Done! Generated #{found_tags.uniq.size} tag pages."
