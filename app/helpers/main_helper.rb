module MainHelper
    def processLinks(str)
        str.gsub('/((https?:)?\\/\\/[^\\s]+)/', '<a style="font-weight: bold;" href="\\1" target="_BLANK">\\1</a>')
    end
end
