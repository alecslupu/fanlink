class Api::V5::RelationshipsController < Api::V4::RelationshipsController
  def index
    person = (params[:person_id].present?) ? Person.find(params[:person_id]) : current_user
    if person == current_user
      update_relationship_count(current_user, @api_version) # FLAPI-89
    end
    @relationships = Relationship.friended.for_person(person)
    if person == current_user
      @relationships += Relationship.pending_to_person(person)
    end
    return_the @relationships, handler: 'jb'
  end

  def show
    @relationship = current_user.relationships.find(params[:id])
    return_the @relationship, handler: 'jb'
  end
end
