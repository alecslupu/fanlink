class SendDownloadFileEmailJob < ApplicationJob
  queue_as :default

  def perform(person_id, certcourse_page_id)
    person = Person.find(person_id)
    certcourse_page = CertcoursePage.find(certcourse_page_id)

    PersonMailer.send_downloaded_file(person, certcourse_page).deliver!
  end
end
