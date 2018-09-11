# https://gist.github.com/shvetsovdm/6317604

json = ActiveSupport::JSON.decode(File.read("db/seeds/starmaker.json"))

json["semesters"].each do |semester|
  sem = Semester.create(product_id: 8, name: semester["name"], description: semester["description"], start_date: semester["start_date"])
  semester["courses"].each do |course|
    cour = Course.create(semester_id: sem.id, name: course["name"], description: course["description"], start_date: course["start_date"])
    course["lessons"].each do |lesson|
      Lesson.create(course_id: cour.id, name: lesson["name"], description: lesson["description"], start_date: lesson["start_date"], video: lesson["video"])
    end
  end
end
