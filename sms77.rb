require 'aliyun/sms'
class Channel::Driver::Sms::Aliyunsms
  NAME = 'sms/aliyunsms'.freeze

  def send(options, attr, _notification = false)
    Rails.logger.info "Sending SMS to recipient #{attr[:recipient]}"
    return true if Setting.get('import_mode')
    Rails.logger.info "Set Aliyun SMS environment #{attr}"
    Aliyun::Sms.configure do |config|
      config.access_key_secret = options[:access_key_secret]   
      config.access_key_id = options[:access_key_id]            
      config.action = 'SendSms'                       # default value
      config.format = 'XML'                           # http return format, value is 'JSON' or 'XML'
      config.region_id = 'cn-hangzhou'                # default value      
      config.sign_name = options[:sign_name]                    
      config.signature_method = 'HMAC-SHA1'           # default value
      config.signature_version = '1.0'                # default value
      config.version = '2017-05-25'                   # default value
    end
    Rails.logger.info "Backend sending aliyun SMS to #{attr[:recipient]}"
    begin
      template_param = {
        "ticket"=>attr[:message],
        "status"=>attr[:recipient]
      }.to_json
      out_id = ''
      if Setting.get('developer_mode') != true
        send_ret = Aliyun::Sms.send(attr[:recipient], options[:template_code], template_param)
        Rails.logger.info "Send SMS Response code #{send_ret.response_code}, body #{send_ret.response_body}"
        raise "发送短信错误" if 200 != send_ret.response_code
      end

      true
    rescue => e
      Rails.logger.debug "aliyun SMS send error: #{e.inspect}"
      raise e
    end
  end

  def self.definition
    {
        name: 'aliyunsms',
        adapter: 'sms/aliyunsms',
        notification: [
            {name: 'options::access_key_secret', display: 'ACCESS KEY SECRET', tag: 'input', type: 'text', limit: 64, null: false, placeholder: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'},
            {name: 'options::access_key_id', display: 'ACCESS KEY ID', tag: 'input', type: 'text', limit: 64, null: false, placeholder: 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'},
            {name: 'options::sign_name', display: '短信签名', tag: 'input', type: 'text', limit: 16, null: true, placeholder: '【蜂雀科技】'},
            {name: 'options::template_code', display: '短信模板', tag: 'input', type: 'text', limit: 16, null: true, placeholder: 'xxxxxxxx'},
        ]
    }
  end
end