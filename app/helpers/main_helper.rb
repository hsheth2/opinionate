module MainHelper
    def processLinks(str)
        n = str.gsub(/((https?:)?\/\/[^\s]+)/, '<a style="font-weight: bold;" href="\1" target="_BLANK">\1</a>')
        n.html_safe
    end
end
