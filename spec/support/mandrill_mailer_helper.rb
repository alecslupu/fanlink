module MandrillMailerHelper
  # def email_sent(template:, to_values:, merge_vars: nil)
  #   MandrillMailer.deliveries.detect { |mail|
  #     mail.template_name == template &&
  #       mail.message["to"].any? { |to| to[:email] == to_values[:email] && to[:name] == to_values[:name] } &&
  #       check_merge_vars(mail.message["global_merge_vars"], merge_vars)
  #   }
  # end
  #
  # private
  #
  # def check_merge_vars(merge_vars, vars)
  #   return merge_vars.empty? if vars.nil? || vars.empty?
  #   if vars
  #     return false if merge_vars.empty?
  #     vars.each do |k, v|
  #       return false unless merge_vars.include?("name" => k, "content" => v)
  #     end
  #   end
  #   true
  # end
end
