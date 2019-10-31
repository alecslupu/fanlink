class Api::V4::Courseware::Client::CertcoursesController < ApiController
  # cauti cursurile ptr acel certificat
    # le poti da id-ul quizz-ului la show
  def index
    @certificate = Certificate.find_by(id: params[:certificate_id])
    if @certificate.nil?
      @certificate = Certificate.create(
        id: params[:certificate_id],
        long_name: "First Certificate Test",
        short_name: "1st Cert Test",
        description: "This is the first certificate ever created",
        certificate_order: 1,
        color_hex: "#000000",
        status: "entry",
        room_id: nil,
        is_free: false,
        sku_ios: "com.musicto.fanlink.caned.demo_nevada_dispensary_education",
        sku_android: "1111",
        validity_duration: 1000000,
        access_duration: 1000000,
        certificate_issuable: false,
        created_at: DateTime.parse("Thu, 21 Feb 2019 15 :14:58 UTC +00:00"),
        updated_at: DateTime.parse("Mon, 11 Mar 2019 14 :02:52 UTC +00:00"),
        template_image_file_name: "Certificate_-_V1.jpg",
        template_image_content_type: "image/jpeg",
        template_image_file_size: 679079,
        template_image_updated_at: DateTime.parse("Mon, 11 Mar 2019 14 :02:49 UTC +00:00"),
        product_id: current_user.product.id
      )
    end
    id = Certcourse.last.nil? ? 1 : Certcourse.last.id
    @certcourses = [Certcourse.create( id: id + 1, long_name: "Test no pages 8", short_name: "Test no pages 8", description: "Test no pages 8", color_hex: "#000000", status: "entry", duration: 5568798, is_completed: false, copyright_text: "text", created_at: DateTime.parse("Mon, 11 Mar 2019 18:34:20 UTC +00:00"), updated_at: DateTime.parse("Mon, 11 Mar 2019 18:34:20 UTC +00:00"), product_id: current_user.product.id, certcourse_pages_count: 2 )]
    @certcourses << Certcourse.create( id: id + 2, long_name: "Test no pages 9", short_name: "Test no pages 9", description: "Test no pages 9", color_hex: "#000000", status: "live", duration: 100000, is_completed: false, copyright_text: "text", created_at: DateTime.parse("Mon, 11 Mar 2019 18:34:41 UTC +00:00"), updated_at: DateTime.parse("Mon, 11 Mar 2019 18:34:41 UTC +00:00"), product_id: current_user.product.id, certcourse_pages_count: 3 )
    @certcourses << Certcourse.create( id: id + 3, long_name: "Test no pages 9", short_name: "Test no pages 10", description: "Not started", color_hex: "#000000", status: "live", duration: 100000, is_completed: false, copyright_text: "text", created_at: DateTime.parse("Mon, 11 Mar 2019 18:34:41 UTC +00:00"), updated_at: DateTime.parse("Mon, 11 Mar 2019 18:34:41 UTC +00:00"), product_id: current_user.product.id, certcourse_pages_count: 3 )
    @certcourses << Certcourse.create( id: id + 4, long_name: "Test no pages 9", short_name: "Test no pages 11", description: "Completed", color_hex: "#000000", status: "live", duration: 100000, is_completed: true, copyright_text: "text", created_at: DateTime.parse("Mon, 11 Mar 2019 18:34:41 UTC +00:00"), updated_at: DateTime.parse("Mon, 11 Mar 2019 18:34:41 UTC +00:00"), product_id: current_user.product.id, certcourse_pages_count: 10 )
    orders = CertificateCertcourse.where(certificate_id: @certificate.id).map(&:certcourse_order)
    number = rand(50000)
    while number.in? orders
      number = rand(50000)
    end
    CertificateCertcourse.create(certificate_id: @certificate.id, certcourse_id: @certcourses.first.id, certcourse_order: number)
    orders << number
    while number.in? orders
      number = rand(50000)
    end
    CertificateCertcourse.create(certificate_id: @certificate.id, certcourse_id: @certcourses.second.id, certcourse_order: number)
      orders << number
    while number.in? orders
      number = rand(50000)
    end
    CertificateCertcourse.create(certificate_id: @certificate.id, certcourse_id: @certcourses.third.id, certcourse_order: number)
    orders << number
    while number.in? orders
      number = rand(50000)
    end
    CertificateCertcourse.create(certificate_id: @certificate.id, certcourse_id: @certcourses.last.id, certcourse_order: number)
    @certificate.reload
    return_the @certcourses, handler: :jb
  end

  def show
    quiz1 = {
      id: 1,
      is_optional: false,
      no_of_failed_attempts: rand(20),
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 25,
      page_order: 12,
      is_correct: true
    }

    quiz2 = {
      id: 2,
      is_optional: true,
      no_of_failed_attempts: 1,
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 36,
      page_order: 8,
      is_correct: false
    }

    quiz3 = {
      id: 3,
      is_optional: false,
      no_of_failed_attempts: rand(20),
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 25,
      page_order: 12,
      is_correct: true
    }

    quiz4 = {
      id: 4,
      is_optional: true,
      no_of_failed_attempts: 0,
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 36,
      page_order: 8,
      is_correct: true
    }

    quiz5 = {
      id: 5,
      is_optional: false,
      no_of_failed_attempts: rand(20),
      quiz_text: Faker::Lorem.sentence,
      answer_text: Faker::Lorem.sentence,
      certcourse_pages_count: 25,
      page_order: 12,
      is_correct: false
    }

    @quizzes = [quiz1, quiz2, quiz3, quiz4, quiz5]
    return_the @quizzes, handler: :jb
  end
end
