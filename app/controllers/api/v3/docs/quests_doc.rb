class Api::V3::Docs::ActivtyTypesDoc < Api::V3::Docs::BaseDoc
  doc_tag name: 'Quests', desc: "Quests"
  route_base 'api/v3/quests'
  components do
    resp :QuestObject  => ['HTTP/1.1 200 Ok', :json, data:{
      :quest => :QuestJson
    }]

    resp :QuestArray  => ['HTTP/1.1 200 Ok', :json, data:{
      :quests => [
        :quest => :QuestJson
      ]
    }]

    body! :QuestCreateForm, :form, data: {
      :quest! => {
        :event_id => { type: Integer, desc: 'The event a quest is attached to. Optional.'},
        :name! => { type: Object, desc: 'Name of the quest. Can be string or an object. Translatable.' },
        :internal_name! => { type: String, desc: 'Internal name of the quest.' },
        :description! => { type: Object, desc: 'Description of the quest. Can be string or object. Translatable.' },
        :picture => { type: File, desc: 'Image associated with the quest.' },
        :status => { type: String, desc: 'Current quest status. Can be Active, Enabled, Disabled or Deleted' },
        :starts_at! => { type: String, format: 'date-time', desc: 'String for when the quest starts.'},
        :end_at => { type: String, format: 'date-time', desc: 'String for when the quest ends.'},
      }
    }

    body! :QuestUpdateForm, :form, data: {
      :quest! => {
        :event_id => { type: Integer, desc: 'The event a quest is attached to. Optional.'},
        :name => { type: Object, desc: 'Name of the quest. Can be string or an object. Translatable.' },
        :internal_name => { type: String, desc: 'Internal name of the quest.' },
        :descriptio! => { type: Object, desc: 'Description of the quest. Can be string or object. Translatable.' },
        :picture => { type: File, desc: 'Image associated with the quest.' },
        :status => { type: String, desc: 'Current quest status. Can be Active, Enabled, Disabled or Deleted' },
        :starts_at => { type: String, format: 'date-time', desc: 'String for when the quest starts.'},
        :end_at => { type: String, format: 'date-time', desc: 'String for when the quest ends.'},
      }
    }
  end

  api :index, 'Get all viewable quests' do
    need_auth :SessionCookie
    desc 'Returns all quests for the current user\'s product that aren\'t deleted.'
    response_ref 200 => :QuestArray
  end

  api :list, 'Get all quests (Admin Only)' do
    need_auth :SessionCookie
    desc 'Returns all quests for the current user\'s product regardless of status.'
    response_ref 200 => :QuestArray
  end

  api :create, 'Create a quest' do
    need_auth :SessionCookie
    desc 'Creates a quest for the current user\'s product.'
    body_ref :QuestCreateForm
    response_ref 200 => :QuestObject
  end

  api :show, 'Find a quest' do
    need_auth :SessionCookie
    desc 'Returns the quest for the given ID'
    response_ref 200 => :QuestObject
  end

  api :update, 'Update a quest' do
    need_auth :SessionCookie
    desc 'Updates the quest for the given id'
    body_ref :QuestUpdateForm
    response_ref 200 => :QuestObject
  end

  api :destroy, 'Destroy a quest' do
    need_auth :SessionCookie
    desc 'Soft deletes a quest'
    response_ref 200 => :OK
  end
end
