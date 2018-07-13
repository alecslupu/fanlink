class Api::V2::Docs::EventsDoc < Api::V2::Docs::BaseDoc
  doc_tag name: 'Events', desc: "Events"
  route_base 'api/v2/events'

  components do
    resp :EventsArray => ['HTTP/1.1 200 Ok', :json, data:{
      :events => [
        :event => :Event
      ]
    }]
    resp :EventsObject => ['HTTP/1.1 200 Ok', :json, data:{
      :event => :Event
    }]
  end

  api :index, "Get all events for a product" do
    need_auth :SessionCookie
    query :from_date, String, format: "date-time", desc: 'Only include events starting on or after date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    query :to_date, String, format: "date-time", desc: 'Only include events starting on or before date in format "YYYY-MM-DD". Note valid dates start from 2017-01-01.'
    response_ref 200 => :EventsArray
  end

  api :show, "Get a single event by id" do
    response_ref 200 => :EventsObject
  end
end
