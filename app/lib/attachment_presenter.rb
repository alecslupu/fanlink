class AttachmentPresenter

  def initialize(asset)
    @asset = asset
  end

  def url
    asset.attached? ? full_url(asset.key) : nil
  end

  def optimal_url
    opts = { resize: '1000', auto_orient: true, quality: 75 }
    asset.attached? ? full_url(asset.variant(opts).processed.key) : nil
  end

  def quality_optimal_url
    opts = { resize: '1920x1080', auto_orient: true, quality: 90 }
    asset.attached? ? full_url(asset.variant(opts).processed.key) : nil
  end

  protected
  attr_reader :asset

  def full_url(from)
    [Rails.application.secrets.cloudfront_url, from].join('/')
  end
end
