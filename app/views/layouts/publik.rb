require_dependency 'layouts/base_public.rb'
class Layouts::Publik < Layouts::BasePublic
  include do
    def html
      content_for :after_stylesheet_libraries do
        stylesheet_link_tag("gko-core/public/loader",
                            "gko-core/public/layout",
                            "gko-core/public/menu",
                            "gko-core/public/forms",
                            "gko-core/public/notice",
                            "public", :cache => 'compiled/public')
       end
       content_for :after_javascript_libraries do
         javascript_include_tag("gko-core/jquery-1.6.2.min.js",
                                "gko-core/jquery-ui-1.8.11.custom.min.js",
                                "gko-core/rails",
                                "gko-core/gko/core",
                                "gko-core/jquery.mobile.events.js",
                                "gko-core/gko/galleria", 
                                "jquery.jscrollpane.min.js",
                                "public", :cache => 'compiled/public')
      end
      super
    end
    
    def build
      div(:id => "wrapper-wide-background-slideshow ", :class => "wrapper-wide #{resource_instance_name}") do
        div(:id => "background-slideshow", :class => "container") do
          render :partial => 'images/shared/list', 
            :locals => { 
              :images => background_images,
              :image_style => 'x570',
              :thumb_style => '110x110'
            }
        end
      end if background_images.any?
      super
    end
    
    
    def background_images
      @background_images ||= begin
        if resource.respond_to?(:images) && resource.images.any?
          resource.images.order(:position)
        else
          site.sections.main.images.order(:position)
        end
      end
    end
    
    def crumbs
      # no crumbs
    end
  end
end
