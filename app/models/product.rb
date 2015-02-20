class Product < ActiveRecord::Base
  has_many :order_items
   has_attached_file :productimage,
    :styles => {
      :thumb => "100x100#",
      :small  => "150x150>",
      :medium => "200x200" }
  validates_attachment_content_type :productimage, :content_type => /\Aimage\/.*\Z/
  validates :name, :price, :presence => true
  # add a delete_<productimage_name> method: 
  attr_accessor :delete_productimage
  before_validation { self.productimage.clear if self.delete_productimage == '1' }

  default_scope { where(active: true) }

     rails_admin do   
		   edit do 
		   	 field :name
      		 field :price
      		 field :active
      		 field :productimage
      		 field :description, :ck_editor
		   end
		   list do
		     field :name 
		     field :price
		     field :active
		     field :created_at
		    end
  		end
end
