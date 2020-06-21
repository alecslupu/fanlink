# frozen_string_literal: true
module Api
  module V4
    module Courseware
      module Client
        class CertificatesController < BaseController
          # frozen_string_literal: true
          before_action :load_person_certificate, only: [:download, :send_email]

          def index
            @certificates = Person.find(params[:person_id]).certificates
            @person = Person.find(params[:person_id])
            return_the @certificates, handler: :jb
          end

          def download
            if @person_certificate.issued_certificate_image.present?
              @url = @person_certificate.issued_certificate_image.url
              return_the @url, handler: :jb
            else
              render_422 _('This user does not have a image attached to this certificate.')
            end
          end

          def send_email
            if @person_certificate.issued_certificate_pdf.present?
              current_user.send_assignee_certificate_email(@person_certificate, params[:person_id], params[:email])
              render json: {message: _('Email sent')}
            else
              render_422 _('This user does not have a pdf file attached to this certificate.')
            end
          end

          private

          def load_person_certificate
            @person_certificate = PersonCertificate.where(certificate_id: params[:id], person_id: params[:person_id]).last
            render_404 if @person_certificate.blank?
          end
        end
      end
    end
  end
end

