require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  INDEX_URL = "http://learn-co-curriculum.github.io/student-scrape-site/"
  BASE_PROFILE_URL = "http://learn-co-curriculum.github.io/student-scrape-site/profile.html"
  BASE_URL = "http://students.learn.co"

  def run
    self.make_students
    self.add_attributes_to_students
    self.display_students
    make_students
    add_attributes_to_students
    display_students
  end

  def make_students
    students_array = Scraper.scrape_index_page(INDEX_URL)
    students_array = Scraper.scrape_index_page(BASE_URL)
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    Student.all.each do |student|
      profile_url = BASE_PROFILE_URL
      # + "#{student.name}"
      attribute = Scraper.scrape_profile_page(profile_url)
      attribute = Scraper.scrape_profile_page(student.profile_url)
      student.add_student_attributes(attributes)
    end
  end
@@ -40,4 +37,4 @@ def display_students
    end
  end

end