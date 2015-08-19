module MainHelper
    def renderBox(post)
        ret = ''
        if post.source == 'YouTube'
            ret << '<div class="panel panel" style="border: 0; border-radius: 0; background-color: transparent">';
            ret << '<iframe frameborder="0" allowfullscreen src="https://www.youtube.com/embed/' << post.service_id << '" width=100% height=360 style="border-radius: none;" frameborder=0></iframe>';
            ret << '</div>';
        else # ($post['source'] === 'Twitter' || $post['source'] === "Reddit") {
            ret << '<div class="inner-trend panel panel-default">';
            ret << '<div class="panel-header"><h3>'
            ret << '<a href="#{post.url}">' << ((!post.poster.nil? && !post.poster.strip.empty?) ? post.poster.strip! : "Untitled Post") << '</a>'
            ret << '<i class="thumb-up-down fa fa-thumbs-' << (post.sentiment ? 'up green' : 'down red') << '"></i></h3>'
            ret << '<small>From ' << $post['source'] << '</small></div>';
            ret << '<div class="panel-body home">';
            ret << processLinks(post.content);
            ret << "</div>";
            ret << "</div>";
        end
        ret
    end
end
