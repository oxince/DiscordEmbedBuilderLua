MessageEmbed = {};
MessageEmbed.__index = MessageEmbed;

function MessageEmbed.New()
  local self = setmetatable({}, MessageEmbed);
  self.embed = {};
  self.embed['fields'] = {};
  self.embed['footer'] = {};
  return self;
end

function MessageEmbed.SetColor(self, color)
  self.embed['color'] = ConvertColorToDecimal(color);
  return self;
end

function MessageEmbed.SetAuthor(self, name, icon_url, url)
  self.embed['author'] = {
    ['name'] = name,
    ['url'] = url,
    ['icon_url'] = icon_url,
  };
  return self;
end

function MessageEmbed.SetTitle(self, title, url)
  self.embed['title'] = title;
  self.embed['url'] = url;
  return self;
end

function MessageEmbed.SetDescription(self, description)
  self.embed['description'] = description;
  return self;
end

function MessageEmbed.AddField(self, name, value, inline)
  table.insert(self.embed['fields'], {
    ['name'] = name,
    ['value'] = value,
    ['inline'] = inline or false
  });
  return self;
end

function MessageEmbed.SetImage(self, url)
  self.embed['image'] = {
    ['url'] = url
  };
  return self;
end

function MessageEmbed.SetThumbnail(self, url)
  self.embed['thumbnail'] = {
    ['url'] = url
  };
  return self;
end

function MessageEmbed.SetFooter(self, text, icon_url)
  self.embed['footer'] = {
    ['text'] = text,
    ['icon_url'] = icon_url
  };
  return self;
end

function MessageEmbed.SetTimestamp(self)
  self.embed['timestamp'] = os.date("!%Y-%m-%dT%H:%M:%SZ");
  return self;
end

function GetColorType(color) 
  if string.find(tostring(color), '0x') then return 'rawHex' end;
  if string.find(tostring(color), '#') then return 'hex' end;
  if tonumber(color) then return 'decimal' end;
  if type(color) == "vector3" then return 'rgb' end;
  return nil;
end

function ConvertColorToDecimal(color) 
  local colorType = GetColorType(color);

  if colorType == 'rgb' then
    local r, g, b = color[1], color[2], color[3];
    local cR, cG, cB = string.format("%02x", r), string.format("%02x", g), string.format("%02x", b);
    local rawHex = "0x"..cR..cG..cB;
    local decimal = tonumber(rawHex);
    return decimal, rawHex, color;
  end
  
  if colorType == 'rawHex' then
    local decimal = tonumber(color);
    return decimal, color;
  end

  if colorType == 'hex' then
    local rawHex = color:gsub('#', '0x');
    local decimal = tonumber(rawHex);
    return decimal, rawHex;
  end

  if colorType == 'decimal' then
    return color;
  end

  return nil;
end
