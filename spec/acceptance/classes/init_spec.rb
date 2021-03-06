# frozen_string_literal: true

require 'spec_helper_acceptance'

RSpec.describe 'Including class "cups"' do
  describe 'default class inclusion' do
    context 'when applying' do
      let(:manifest) { 'include cups' }

      it 'applies without error' do
        apply_manifest(manifest)
      end

      it 'is idempotent' do
        apply_manifest(manifest, catch_changes: true)
      end
    end

    describe 'after applying' do
      describe service('cups') do
        it { should be_running }
        it { should be_enabled }
      end

      describe file('/usr/bin/ipptool') do
        it { should be_executable }
      end
    end
  end
end
