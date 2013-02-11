class Vendor < User

  validates :billing_address_city, :billing_address_county, :billing_address_line1,
            :billing_address_line2, :company_name, presence: true
  validates :company_name, uniqueness: true

  has_secure_password
end
