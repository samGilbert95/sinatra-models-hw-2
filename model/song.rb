class Person

  attr_accessor :id,:first_name,:last_name,:email,:gender,:ip_address

  def self.open_connection
    conn = PG.connect(dbname: 'people')
  end

  def save
    conn = Person.open_connection
    #If the class instance that we're running
    # the save method on does not have an id
    #  then create, else update
    if !self.id
      sql = "INSERT INTO MOCK_DATA (first_name,last_name,email,gender,ip_address) VALUES ('#{self.first_name}','#{self.last_name}','#{self.email}','#{self.gender}','#{self.ip_address}')"
    else
      sql = "UPDATE MOCK_DATA SET first_name='#{self.first_name}',last_name='#{self.last_name}',email='#{self.email}',gender='#{self.gender}',ip_address='#{self.ip_address}' WHERE id=#{self.id}"
    end
    conn.exec(sql)
  end

  def self.hydrate people_data
    person = Person.new
    person.id = people_data['id']
    person.first_name = people_data['first_name']
    person.last_name = people_data['last_name']
    person.email = people_data['email']
    person.gender = people_data['gender']
    person.ip_address = people_data['ip_address']

    person
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM MOCK_DATA ORDER BY id"
    results = conn.exec(sql)
    people = results.map do |person|
      self.hydrate person
    end
  end

  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM MOCK_DATA WHERE id=#{id}"
    results = conn.exec(sql)
    person = self.hydrate results[0]
    person
  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM MOCK_DATA WHERE id=#{id}"
    conn.exec(sql)
  end
end
