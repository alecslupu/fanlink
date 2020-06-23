# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AwsController, type: :controller do
  describe 'POST video_transcoded' do
    before do
      stub_request(:post, 'https://sns.us-east-1.amazonaws.com/')
    end
    let(:arn) { 'arn:aws:sns:us-east-1:390209539631:fanlink-staging-video' }
    it 'SubscriptionConfirmation' do
      data = {
        Type: 'SubscriptionConfirmation',
        MessageId: '165545c9-2a5c-472c-8df2-7ff2be2b3b1b',
        Token: '2336412f37f...',
        TopicArn: arn,
        Message: "You have chosen to subscribe to the topic arn:aws:sns:us-west-2:123456789012:MyTopic.
To confirm the subscription, visit the SubscribeURL included in this message.",
        SubscribeURL: "https://sns.us-west-2.amazonaws.com/?Action=ConfirmSubscription&TopicArn=#{arn}&Token=2336412f37...",
        Timestamp: '2012-04-26T20:45:04.751Z',
        SignatureVersion: '1',
        Signature: 'EXAMPLEpH+...',
        SigningCertURL: 'https://sns.us-west-2.amazonaws.com/SimpleNotificationService-f3ecfb7224c7233fe7bb5f59f96de52f.pem'
      }.to_json

      request.headers.merge!({
                               'x-amz-sns-message-type' => 'SubscriptionConfirmation',
                               'x-amz-sns-topic-arn' => arn
                             })
      post :video_transcoded, body: data
    end
    it 'SubscriptionConfirmation' do
      data = {
        Type: 'Notification',
        MessageId: '391eb1f6-592d-51b5-acb8-e6b54ad2e29e',
        TopicArn: arn,
        Subject: 'Amazon Elastic Transcoder has finished transcoding job 1590235577095-lddxsq.',
        Message: {
          state: 'COMPLETED',
          version: '2012-09-25',
          jobId: '1590235577095-lddxsq',
          pipelineId: '1540734249765-3fl9wc',
          input: {
            key: 'caned/posts/videos/000/025/987/original/cd03750dab9d036dae1e466e65275711ec14b938.MOV'
          },
          inputCount: 1,
          outputs: [{
            id: '1',
            presetId: '1542983455511-yqngpd',
            key: 'caned/posts/videos/000/025/987/transcoded/cd03750dab9d036dae1e466e65275711ec14b938-v-1080p.mp4',
            thumbnailPattern: 'thumbnails/cd03750dab9d036dae1e466e65275711ec14b938-{count}',
            status: 'Complete',
            duration: 11,
            width: 360,
            height: 480
          }],
          userMetadata: {
            post_id: '25987',
            sizer: 't'
          }
        }.to_json,
        Timestamp: '2020-05-23T12:06:23.016Z',
        SignatureVersion: '1',
        Signature: 'n6kQwO+5GYwc+facBU6/VgUJosm2czJlti85vPVGHMHwK/ZibP/vXfsb43uamNJ5rgOKYuypWe3TyqJ8e9WDAJd/1O6aZFCoBRzJ+gYJuXH8FmsT+TCOzNLCZCwN7+VmrVeripus5uRuPanFeOiOlFLz9yRd821J/96TiFalZiAP2dKd9I8dziG83anNG+zjNWVituX8OkWOzouosqaL7PnDRcsmtCY0zslTIhsWN0my4lfT0MtcgS1AS3N4n66rCQ+Q3nYqcvsSZ7uGL+wRHOXQ4aXs6yAPyC0n/YavEGfUqsh3uEKw6Y2KH21wwjbEye5+d2YqPTOPyngIeonODg==',
        SigningCertURL: 'https://sns.us-east-1.amazonaws.com/SimpleNotificationService-a86cb10b4e1f29c941702d737128f7b6.pem',
        UnsubscribeURL: 'https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:390209539631:fanlink-staging-video:1ad3650a-6a92-4726-a348-134913df6abb'
      }
      request.headers.merge!({
                               'x-amz-sns-message-type' => 'notification',
                               'x-amz-sns-topic-arn' => arn
                             })
      post :video_transcoded, body: data.to_json
    end
  end
end
