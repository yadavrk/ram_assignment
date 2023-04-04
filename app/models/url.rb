class Url < ApplicationRecord
    validates_presence_of :long_url
    validates :long_url, url: true
    validates_uniqueness_of :short_url

    before_validation :generate_short_url
    before_validation :sanatize

    private
    def generate_short_url
        short_url = ([*('a'..'z'), *('0'..'9')]).sample(8).join
        if Url.where(short_url: short_url).any?
            self.generate_short_url
        else
            self.short_url = short_url
        end
    end

    def sanatize
        long_url.strip!
    end
end
