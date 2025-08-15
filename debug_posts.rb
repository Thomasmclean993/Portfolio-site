#!/usr/bin/env ruby
require 'yaml'
require 'date'
require 'fileutils'

# --- Configuration ---
POSTS_DIR = "_posts" # Path to your posts folder
TAG_TO_TEST = "whoami" # The tag you want to simulate filtering

# --- Storage ---
all_posts = []
all_tags  = []

# --- Parse Posts ---
Dir.glob(File.join(POSTS_DIR, "*.{md,markdown,html}")).each do |file|
  next unless File.file?(file)

  content = File.read(file)

  # Extract YAML front matter
  if content =~ /\A---\s*\n(.*?)\n---\s*\n/m
    begin
      fm = YAML.safe_load($1, permitted_classes: [Time, Date], aliases: true)

      title = fm["title"] || File.basename(file)
      date  = fm["date"] ? Date.parse(fm["date"].to_s) : nil
      tags  = Array(fm["tags"]).map(&:to_s)
      slug  = File.basename(file, File.extname(file)).gsub(/^\d+-\d+-\d+-/, "")
      url   = "/#{slug}/"

      all_posts << { title: title, date: date, tags: tags, url: url }
      all_tags.concat(tags)

    rescue Psych::SyntaxError => e
      puts "YAML parse error in #{file}: #{e.message}"
    end
  end
end

# --- Sort and dedupe ---
all_posts.sort_by! { |p| p[:date] || Date.today }.reverse!
all_tags.uniq!.sort!

# --- Output ---
puts "\n📝 All Posts:"
all_posts.each do |post|
  puts " - #{post[:title]} (#{post[:date]})"
  puts "   URL: #{post[:url]}"
  puts "   Tags: #{post[:tags].join(", ")}"
end

puts "\n🏷 All Unique Tags:"
all_tags.each_with_index { |tag, i| puts " #{i+1}. #{tag}" }

puts "\n🔍 Posts with tag '#{TAG_TO_TEST}':"
matches = all_posts.select { |p| p[:tags].map(&:downcase).include?(TAG_TO_TEST.downcase) }
if matches.empty?
  puts "  No posts found for tag '#{TAG_TO_TEST}'."
else
  matches.each do |post|
    puts " - #{post[:title]} (#{post[:date]}) — #{post[:url]}"
  end
end
