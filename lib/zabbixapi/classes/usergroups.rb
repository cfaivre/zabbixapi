class ZabbixApi
  class Usergroups < Basic

    def method_name
      "usergroup"
    end

    def key
      "usrgrpid"
    end

    def indentify
      "name"
    end

    # Return usrgrpid
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :name => "UserGroup"
    # * *Returns* :
    #   - Integer
    def get_or_create(data)
      usrgrpid = get_id(data)
      if usrgrpid.nil?
        usrgrpid = create(data)
      end
      usrgrpid
    end

    # Set permission for usrgrp on some hostgroup
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :usrgrpids => id, :hostgroupids => [], :permission => 2,3 (read and read write)
    # * *Returns* :
    #   - Integer
    def set_perms(data)
      permission = data[:permission] || 2 
      result = @client.api_request(
        :method => "usergroup.massAdd", 
        :params => {
          :usrgrpids => [data[:usrgrpid]],
          :rights => data[:hostgroupids].map { |t| {:permission => permission, :id => t} }
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Update usergroup, add user
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :usrgrpids => id, :userids => []
    # * *Returns* :
    #   - Integer
    def add_user(data)
      result = @client.api_request(
        :method => "usergroup.massAdd", 
        :params => {
          :usrgrpids => data[:usrgrpids],
          :userids => data[:userids]
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

    # Update usergroup, modify users
    # 
    # * *Args*    :
    #   - +data+ -> Hash with :usrgrpids => id, :userids => []
    # * *Returns* :
    #   - Integer
    def update_users(data)
      result = @client.api_request(
        :method => "usergroup.massUpdate", 
        :params => {
          :usrgrpids => data[:usrgrpids],
          :userids => data[:userids]
        }
      )
      result ? result['usrgrpids'][0].to_i : nil
    end

  end
end
