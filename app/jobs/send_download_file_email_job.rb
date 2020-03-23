class SendDownloadFileEmailJob < Struct.new(:person_id, :certcourse_page_id)
  def perform
    person = Person.find(person_id)
    certcourse_page = CertcoursePage.find(certcourse_page_id)

    PersonMailer.send_downloaded_file(person, certcourse_page).deliver
  end

  def queue_name
    :default
  end
end
