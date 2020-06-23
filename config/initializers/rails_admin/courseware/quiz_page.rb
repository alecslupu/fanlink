# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('QuizPage')
  config.model 'QuizPage' do
    parent 'Certificate'

    configure :course_name do
    end

    edit do
      fields :certcourse_page, :is_optional, :is_survey, :quiz_text, :wrong_answer_page_id, :answers
    end
    list do
      field :id
      field :course_name do
        searchable [{ Certcourse => :short_name }]
        queryable true
      end
      fields :quiz_text, :answers, :is_optional, :is_survey
    end
    show do
      fields :id, :certcourse_page, :is_optional, :is_survey, :quiz_text, :wrong_answer_page_id
      field :answers do
        pretty_value do
          v = bindings[:view]
          [value].flatten.select(&:present?).collect do |associated|
            amc = polymorphic? ? RailsAdmin.config(associated) : associated_model_config # perf optimization for non-polymorphic associations
            am = amc.abstract_model

            icon = case associated.is_correct?
                   when false
                     %(<span class='label label-danger'>&#x2718;</span>)
                   when true
                     %(<span class='label label-success'>&#x2713;</span>)
                   else
                     %(<span class='label label-default'>&#x2012;</span>)
                   end
            wording = associated.send(amc.object_label_method)
            can_see = !am.embedded? && (show_action = v.action(:show, am, associated))
            link = v.link_to(wording, v.url_for(action: show_action.action_name, model_name: am.to_param, id: associated.id), class: 'pjax')
            [can_see ? link : ERB::Util.html_escape(wording), icon].join
          end.to_sentence.html_safe
        end
      end
    end

    nested do
      exclude_fields :certcourse_page
    end
  end
end
