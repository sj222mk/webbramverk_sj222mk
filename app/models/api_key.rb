class ApiKey < ActiveRecord::Base  
  belongs_to :user
  #attr_accessible :access_token, :expires_at, :user_id, :active, :application
  before_create :generate_access_token
  before_create :set_expiration
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 255 }

  def expired?
    DateTime.now >= self.expires_at
  end

  private
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  def set_expiration
    self.expires_at = DateTime.now+30
  end
end  