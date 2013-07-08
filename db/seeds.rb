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
m = Component.new
m.name = 'Meta'
m.slug = 'meta'
m.save!
b = Component.new
b.name = 'Body'
b.slug = 'body'
b.save!
s = Component.new
s.name = 'Sound'
s.slug = 'sound'
s.save!
v = Component.new
v.name = 'Video'
v.slug = 'video'
v.save!
i = Component.new
i.name = 'Image'
i.slug = 'image'
i.save!
g = Component.new
g.name = 'Gallery'
g.slug = 'gallery'
g.save!

# Create templates with the components
t = Template.new
t.name = "Video"
t.slug = "video"
t.save!
t.template_components.create(:component => v, :order => 0)
t.template_components.create(:component => m, :order => 1)
t.template_components.create(:component => b, :order => 2)
t.save!
t = Template.new
t.name = "Sound"
t.slug = "sound"
t.save!
t.template_components.create(:component => i, :order => 0)
t.template_components.create(:component => m, :order => 1)
t.template_components.create(:component => s, :order => 2)
t.template_components.create(:component => b, :order => 3)
t.save!
t = Template.new
t.name = "Gallery"
t.slug = "gallery"
t.save!
t.template_components.create(:component => g, :order => 0)
t.template_components.create(:component => m, :order => 1)
t.template_components.create(:component => b, :order => 2)
t.save!

# Create test categories
c = Category.new
c.name = "Test Category 1"
c.slug = "test-category-1"
c.save!
c = Category.new
c.name = "Test Category 2"
c.slug = "test-category-2"
c.save!

# Create test series
s = Series.new
s.name = "Test Series 1"
s.slug = "test-series-1"
s.save!
s = Series.new
s.name = "Test Series 2"
s.slug = "test-series-2"
s.save!