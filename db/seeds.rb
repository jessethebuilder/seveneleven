require 'csv'

IntlStore.destroy_all

first = true

CSV.foreach(Rails.root.join('data/intl.csv')) do |row|
  s = IntlStore.new
  INTL_HEADERS.each_with_index do |h, i|
    s.send("#{h}=", row[i])
  end

  unless first
    s.save!
  end

  first = false
end

puts "intl complete"

NaStore.destroy_all

first = true

counter = 0

CSV.foreach(Rails.root.join('data/na.csv')) do |row|
    s = NaStore.new
    # r = row.split(', ')
    NA_HEADERS.each_with_index do |h, i|
      v = row[i]
      if v && NaStore.bool_types.include?(h)
        tst = v.downcase
        if tst == 'y' || tst == 'yes'
          v = true
        else
          v = false
        end
      end

      s.send("#{h}=", v)
    end

    unless first
      s.save!
    end

    first = false
    counter += 1
    # break if counter == 100
end

puts "na complete"
