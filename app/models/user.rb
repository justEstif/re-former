class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /[A-Z]/ && value =~ /[a-z]/ && value =~ /[0-9]/ && value =~ /[^A-Za-z0-9]/
      record.errors.add attribute, (options[:message] || "must contain at least one uppercase letter, one lowercase letter, one number, and one special character")
    end
  end
end

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { in: 4..12 }
  validates :email, presence: true, uniqueness: true, email: true, confirmation: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
end
