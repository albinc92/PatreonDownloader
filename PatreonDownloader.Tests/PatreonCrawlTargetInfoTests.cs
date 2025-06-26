using PatreonDownloader.Implementation;
using Xunit;

namespace PatreonDownloader.Tests
{
    public class PatreonCrawlTargetInfoTests
    {
        [Fact]
        public void Name_SetWithTrailingSpaces_SaveDirectoryHasNoTrailingSpaces()
        {
            var targetInfo = new PatreonCrawlTargetInfo();
            targetInfo.Name = "Princess Jasmine ";

            Assert.Equal("Princess Jasmine", targetInfo.SaveDirectory);
            Assert.False(targetInfo.SaveDirectory.EndsWith(" "), "SaveDirectory should not end with a space");
        }

        [Fact]
        public void Name_SetWithTrailingDotsAndSpaces_SaveDirectoryHasNoTrailingChars()
        {
            var targetInfo = new PatreonCrawlTargetInfo();
            targetInfo.Name = "Test User . ";

            Assert.Equal("Test User", targetInfo.SaveDirectory);
            Assert.False(targetInfo.SaveDirectory.EndsWith(" ") || targetInfo.SaveDirectory.EndsWith("."), 
                "SaveDirectory should not end with space or dot");
        }

        [Fact]
        public void Name_SetWithOnlySpaces_SaveDirectoryIsUnknown()
        {
            var targetInfo = new PatreonCrawlTargetInfo();
            targetInfo.Name = "   ";

            Assert.Equal("Unknown", targetInfo.SaveDirectory);
        }

        [Fact]
        public void Name_SetWithOnlyDots_SaveDirectoryIsUnknown()
        {
            var targetInfo = new PatreonCrawlTargetInfo();
            targetInfo.Name = "...";

            Assert.Equal("Unknown", targetInfo.SaveDirectory);
        }

        [Fact]
        public void Name_SetWithInvalidCharacters_InvalidCharsAreReplacedWithUnderscore()
        {
            var targetInfo = new PatreonCrawlTargetInfo();
            targetInfo.Name = "Test<>User|Name ";

            Assert.Equal("Test__User_Name", targetInfo.SaveDirectory);
        }

        [Fact]
        public void Name_SetNormalName_SaveDirectoryIsUnchanged()
        {
            var targetInfo = new PatreonCrawlTargetInfo();
            targetInfo.Name = "Normal User Name";

            Assert.Equal("Normal User Name", targetInfo.SaveDirectory);
        }
    }
}
