module HashImprovement 

  require 'rubygems'
  require 'xmlsimple'

  def from_xml(xml)
    XmlSimple.xml_in(xml)
  end
  
end
  
Hash.extend(HashImprovement)
