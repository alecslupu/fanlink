RailsAdmin.config do |config|
  config.included_models.push('Relationship')
  config.model 'Relationship' do
    label_plural 'Friend Relationships'
  end
end
