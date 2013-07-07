# Superadmin user
user = User.new
user.username = 'admin'
user.password = 'admin'
user.email    = 'admin@sitename.com'
user.display_name = 'admin'
user.save

# Give user Superadmin role
user.add_role :superadmin

# Create the components
c = Component.new
c.name = 'Meta'
c.slug = 'meta'
c.save!
c = Component.new
c.name = 'Body'
c.slug = 'body'
c.save!
c = Component.new
c.name = 'Sound'
c.slug = 'sound'
c.save!
c = Component.new
c.name = 'Video'
c.slug = 'video'
c.save!
c = Component.new
c.name = 'Image'
c.slug = 'image'
c.save!
c = Component.new
c.name = 'Gallery'
c.slug = 'gallery'
c.save!


