class SendDownloadFileEmailJob < ApplicationJob
  queue_as :mailers

  def perform(person_id, certcourse_page_id)
    PersonMailer.with(id: person_id, certcourse_page_id: certcourse_page_id).send_downloaded_file.deliver_now
  end
end
