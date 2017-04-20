module ApplicationHelper
    def num_to_k(n)
        number = 0..9
        kanji = ["","一","二","三","四","五","六","七","八","九"]
        num_kanji = Hash[number.zip(kanji)]
        digit = [1000,100,10]
        # digit = (1..3).map{ |i| 10 ** i }.reverse
        kanji_keta = ["千","百","十"]
        num_kanji_keta = Hash[digit.zip(kanji_keta)]
        num = n
        str = ""
        digit.each { |d|
            tmp = num / d
            str << (tmp == 0 ? "" : ((tmp == 1 ? "" : num_kanji[tmp]) + num_kanji_keta[d]))
            num %= d
        }
        str << num_kanji[num]
        return str
    end
end