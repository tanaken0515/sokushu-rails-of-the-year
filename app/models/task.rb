class Task < ApplicationRecord
  belongs_to :user

  before_validation :set_nameless_name
  validates :name,
            presence: true,
            length: {maximum: 30}
  validate :validate_name_not_including_comma

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w(name created_at)
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  def set_nameless_name
    self.name = '名前なし' if name.blank?
  end
end