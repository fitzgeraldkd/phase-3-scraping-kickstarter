# require libraries/modules here
require 'nokogiri'
require 'open-uri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    image_link = project.css('div.project-thumbnail a img').attribute('src').value
    description = project.css('p.bbcard_blurb').text
    location = project.css('ul.project-meta li a').text
    percent_funded = project.css('ul.project-stats li.first.funded strong').text.to_i
    projects[title.to_sym] = {image_link: image_link, description: description, location: location, percent_funded: percent_funded}
  end

  projects
end

puts create_project_hash