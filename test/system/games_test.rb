require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "The word isn't in grid" do
    visit new_url
    fill_in 'word', with: 'doesnotexistatall'
    click_on 'Play'
    assert_text "can't be built out of"
  end

  test "The word is in the grid and is not english" do
    visit new_url
    word = find("li:first-child").text + find("li:last-child").text
    fill_in 'word', with: word
    click_on 'Play'
    assert_text "does not seem to be a valid English word.."
  end

  test "The word is english and in the grid" do
    visit new_url
    fill_in 'word', with: find("li:first-child").text
    click_on 'Play'
    assert_text "Congratulations"
  end
end
