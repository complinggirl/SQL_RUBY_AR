class Task < ActiveRecord::Base

  validates :name, :presence => true, :length => { :maximum => 50}

  before_save :downcase_name

  belongs_to(:list)

  def self.not_done
    where(:done => false)
  end


private
    def downcase_name
      name.downcase!
    end
end
