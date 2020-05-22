# frozen_string_literal: true

namespace :papertrail do
  desc "Clean Up the PaperTrail::Versions"
  task clean: :environment do
    protected_models = %w[
      Certcourse
      CertcoursePage
      Certificate
      CertificateCertcourse
      DownloadFilePage
      CoursePageProgress
      PersonCertificate
      PersonCertcourse
      Answer
      QuizPage
      ImagePage
      VideoPage
    ]
    PaperTrail::Version.where("item_type not in (?)", protected_models).where("created_at < ?", 12.months.ago).find_each do |version|
      version.destroy
    end
  end
end
