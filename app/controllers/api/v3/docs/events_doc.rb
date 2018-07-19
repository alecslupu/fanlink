class Api::V3::Docs::EventsDoc < Api::V3::Docs::BaseDoc
  doc_tag name: 'Events', desc: "Events"
  route_base 'api/v3/events'

  components do
    resp :EventsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :events => [
        :event => :EventJson
      ]
    }]
    resp :EventsObject => ['HTTP/1.1 200 Ok', :json, data:{
      :event => :EventJson
    }]

    body! :EventForm, :form, date: {
      :event! => {
        :name! => { type: String,  desc: 'The name of the event.'},
        :description => { type: String, desc: 'A paragraph describing the event.'},
        :starts_at! => { type: String, format: 'date-time', desc: "What date and time the event starts at."},
        :ends_at => { type: String, format: 'date-time', desc: "What date and time the event ends at."},
        :ticket_url => { type: String, desc: 'URL where the user can purchase tickets for the event at.'},
        :place_identifier => { type: String, desc: "An identifier of where the event is held."}
      }
    }
    body! :EventUpdateForm, :form, date: {
      :event! => {
        :name => { type: String,  desc: 'The name of the event.'},
        :description => { type: String, desc: 'A paragraph describing the event.'},
        :starts_at => { type: String, format: 'date-time', desc: "What date and time the event starts at."},
        :ends_at => { type: String, format: 'date-time', desc: "What date and time the event ends at."},
        :ticket_url => { type: String, desc: 'URL where the user can purchase tickets for the event at.'},
        :place_identifier => { type: String, desc: "An identifier of where the event is held."}
      }
    }
  end

  api :index, "Get all events for a product" do
    query :from_date, String, format: "date", desc: 'Only include events starting on or after date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :to_date, String, format: "date", desc: 'Only include events starting on or before date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    response_ref 200 => :EventsArray
  end

  api :show, "Get a single event by id" do
    response_ref 200 => :EventsObject
  end

  api :create, 'Create an event' do
    need_auth :SessionCookie
    desc 'Creates an event for current user\'s product'
    body_ref :EventForm
    response_ref 200 => :EventsObject
  end

  api :update, 'Update an event.' do
  need_auth :SessionCookie
    desc 'Updates the event for given ID.'
    body_ref :EventUpdateForm
    response_ref 200 => :EventsObject
  end

  api :destroy, 'Delete an event.' do
  need_auth :SessionCookie
    desc 'Soft deletes an event by setting deleted to true.'
    response_ref 200 => :OK
  end
end
