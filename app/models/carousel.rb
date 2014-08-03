class Carousel < ActiveRecord::Base
    attr_accessor :photos
    after_initialize :initialized

    def initialized
        @photos = []
        Dir.foreach('app/assets/images/carousel/') do |img|
            next if img == '.' || img == '..'
            @photos.push("/assets/carousel/#{img}")
        end
        @photos
    end
end
