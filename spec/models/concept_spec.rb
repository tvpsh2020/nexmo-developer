require 'rails_helper'

RSpec.describe Concept, type: :model do
  describe '#extract_product' do
    it 'extracts voice successfully' do
      allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
      expect(Concept.extract_product("#{Concept.origin}/#{language}/voice/voice-api/guides/demo.md", language)).to eq('voice/voice-api')
    end

    it 'extracts sms successfully' do
      allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
      expect(Concept.extract_product("#{Concept.origin}/#{language}/messaging/sms/guides/demo.md", language)).to eq('messaging/sms')
    end
  end
  describe '#all' do
    it 'returns all building blocks' do
      stub_available_concepts
      expect(Concept.all(language)).to have(4).items
    end
  end

  describe '#by_name' do
    it 'shows a single match' do
      stub_available_concepts
      expect(Concept.by_name(['voice/voice-api/pstn-update'], language)).to have(1).items
    end
    it 'shows multiple matches' do
      stub_available_concepts
      expect(Concept.by_name(['voice/voice-api/pstn-update', 'messaging/sms/shortcodes'], language)).to have(2).items
    end
  end

  describe '#by_product' do
    it 'shows only sms' do
      stub_available_concepts
      expect(Concept.by_product('messaging/sms', language)).to have(1).items
    end
    it 'shows only voice' do
      stub_available_concepts
      expect(Concept.by_product('voice/voice-api', language)).to have(2).items
    end
  end

  describe '#files' do
    it 'has the correct glob pattern' do
      allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
      expect(Dir).to receive(:glob).with("/path/to/_documentation/#{language}/**/guides/**/*.md") .and_return(['guide'])
      expect(Dir).to receive(:glob).with("/path/to/_documentation/#{language}/**/concepts/**/*.md") .and_return(['concept'])
      expect(Concept.files(language)).to eq(['guide', 'concept'])
    end
  end

  describe '#origin' do
    it 'returns the correct origin' do
      expect(Concept.origin).to eq("#{Rails.root}/_documentation")
    end
  end

  describe '#filename' do
    it 'returns the correct filename' do
      stub_available_concepts
      expect(Concept.all(language).first.filename).to eq('pstn-update')
    end
  end

  describe '.instance' do
    it 'has the expected accessors' do
      stub_available_concepts

      block = Concept.all(language).first
      expect(block.title).to eq('PSTN Update')
      expect(block.description).to eq('Introduction to PSTN')
      expect(block.navigation_weight).to eq(1)
      expect(block.product).to eq('voice/voice-api')
      expect(block.document_path).to eq("#{Concept.origin}/#{language}/voice/voice-api/guides/pstn-update.md")
      expect(block.url).to eq('/voice/voice-api/guides/pstn-update')
      expect(block.ignore_in_list).to eq(true)
    end
  end
end

def stub_available_concepts
  paths = []

  i = 0
  {
    'PSTN Update' => { 'product' => 'voice/voice-api', 'description' => 'Introduction to PSTN', 'ignore_in_list' => true, 'folder' => 'guides' },
    'Shortcodes' => { 'product' => 'messaging/sms', 'description' => 'You can use shortcodes whilst in the US', 'folder' => 'guides' },
    'Demo' => { 'product' => 'voice/voice-api', 'description' => 'Demo Topic', 'folder' => 'guides' },
    'New Concept' => { 'product' => 'verify/concept', 'description' => 'Demo Topic', 'folder' => 'concepts' },
  }.each do |title, details|
    i += 1
    slug = title.parameterize
    path = "/path/to/_documentation/#{language}/#{details['product']}/#{details['folder']}/#{slug}.md"
    paths.push(path)

    allow(File).to receive(:read).with(path) .and_return(
      {
        'title' => title,
        'description' => details['description'],
        'navigation_weight' => i,
        'ignore_in_list' => details['ignore_in_list'] || false,
      }.to_yaml
    )
  end

  allow(Concept).to receive(:origin).and_return('/path/to/_documentation')
  allow(Concept).to receive(:files).and_return(paths)
end

def language
  'en'
end
