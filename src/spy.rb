#$LOAD_PATH = []
Dir.glob( "lib/ruby/*".gsub('%20', ' ')).each  do |dir|
    puts "Loading #{dir}"
    $LOAD_PATH <<   "#{dir}/lib" if File.directory?  "#{dir}/lib"
end

require 'rubygems'
require 'tray_application'
require 'screenshot'
require 'upload'
require 'logo'
require 'base64'
require 'broach'

include Java
import javax.swing.JOptionPane;


###  APP CONFIGURATION

  api_key = "17CDJNOR9c165802dbf503ccd2eaa640307fe4f5"
  Broach.settings = {
    'account' => 'xenda',
    'token'   => "1769bcfa6c5fd00ff96749c1325a2d8491aad6f1"
  
  }
  

### CREATING A NEW APP

  app = TrayApplication.new("Xenda Spy")
  
  File.open('icon.png', 'wb') do |file|
    file << Base64.decode64(Logo::ICON)      
  end
  
  app.icon_filename = "icon.png"

  app.item('Enviar screenshot')  do 
    
      # Capturing the image
      puts "Taking the screenshot"
      filename = "screenshot_#{Time.now.to_s.gsub(" ", "_") }.png"      
      Screenshot.capture(filename)
          
      # Sending it to ImageShack.us
      puts "Sending the image to ImageShack"
      url = Upload.send(api_key, filename)        
    
      #Sending it to Campfire
      puts "Sending it to Campfire"
      Broach.speak('General', "Miren esto: #{filename}")
      Broach.speak('General', url)      
    
      #Showing success message
      puts "Great success!!"
      javax.swing.JOptionPane.showMessageDialog(nil,"Envío Exitoso: #{url}");
    
  end
  
  app.item('Salir') { java.lang.System::exit(0) }
  app.run