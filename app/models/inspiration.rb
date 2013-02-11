class Inspiration < ActiveRecord::Base
  attr_accessible :image, :title, :notes, :website_url
  belongs_to :user
  has_attached_file :image,
                    :styles => {
                        :regular => "300?x320!",
                        :large => "500?x600!",
                        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                        :url => "/system/:attachment/:id/:style/:filename" }
  acts_as_list
end
