class Profile < ActiveRecord::Base
  belongs_to :user

  validate :validate_names
  validate :validate_first_name
  validates :gender, inclusion: %w(male female)
  def validate_names
    if first_name.nil? && last_name.nil?
      errors.add(:first_name, "insert at least either first or last name")
    end
  end

  def validate_first_name
    if first_name == 'Sue' && gender == 'male'
      errors.add(:first_name, 'male cannot be named Sue')
    end
  end

  def self.get_all_profiles(min_year, max_year)
    self.where('birth_year BETWEEN ? AND ?', min_year, max_year).order(birth_year: :asc)
  end
end
