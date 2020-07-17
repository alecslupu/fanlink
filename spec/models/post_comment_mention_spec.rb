# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comment_mentions
#
#  id              :bigint           not null, primary key
#  post_comment_id :integer          not null
#  person_id       :integer          not null
#  location        :integer          default(0), not null
#  length          :integer          default(0), not null
#


RSpec.describe PostCommentMention, type: :model do
  context 'Validation' do
    describe 'should create a valid post comment mention' do
      it do
        expect(build(:post_comment_mention)).to be_valid
      end
    end
  end
end
