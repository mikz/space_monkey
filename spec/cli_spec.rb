describe SpaceMonkey::CLI do

  it 'should starts console' do
    expect(IRB).to receive(:start)
    subject.console
  end
end
