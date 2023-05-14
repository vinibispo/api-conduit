class User::Record < ApplicationRecord
  self.table_name = 'users'

  has_secure_password
end
