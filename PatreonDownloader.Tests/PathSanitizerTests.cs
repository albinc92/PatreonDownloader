using UniversalDownloaderPlatform.Common.Helpers;
using Xunit;

namespace PatreonDownloader.Tests
{
    public class PathSanitizerTests
    {
        [Fact]
        public void SanitizePath_PathWithTrailingSpaces_TrailingSpacesAreRemoved()
        {
            string result = PathSanitizer.SanitizePath("Princess Jasmine ");
            
            Assert.Equal("Princess Jasmine", result);
            Assert.False(result.EndsWith(" "), "Result should not end with a space");
        }

        [Fact]
        public void SanitizePath_PathWithTrailingDotsAndSpaces_TrailingCharsAreRemoved()
        {
            string result = PathSanitizer.SanitizePath("Test User . ");
            
            Assert.Equal("Test User", result);
            Assert.False(result.EndsWith(" ") || result.EndsWith("."), "Result should not end with space or dot");
        }

        [Fact]
        public void SanitizePath_OnlySpaces_ReturnsUnknown()
        {
            string result = PathSanitizer.SanitizePath("   ");
            
            Assert.Equal("Unknown", result);
        }

        [Fact]
        public void SanitizePath_OnlyDots_ReturnsUnknown()
        {
            string result = PathSanitizer.SanitizePath("...");
            
            Assert.Equal("Unknown", result);
        }

        [Fact]
        public void SanitizePath_EmptyString_ReturnsUnknown()
        {
            string result = PathSanitizer.SanitizePath("");
            
            Assert.Equal("Unknown", result);
        }

        [Fact]
        public void SanitizePath_NullString_ReturnsUnknown()
        {
            string result = PathSanitizer.SanitizePath(null);
            
            Assert.Equal("Unknown", result);
        }

        [Fact]
        public void SanitizePath_PathWithInvalidCharacters_InvalidCharsAreReplacedWithUnderscore()
        {
            string result = PathSanitizer.SanitizePath("Test<>Path|Name ");
            
            Assert.Equal("Test__Path_Name", result);
        }

        [Fact]
        public void SanitizePath_NormalPath_PathIsUnchanged()
        {
            string result = PathSanitizer.SanitizePath("Normal Path Name");
            
            Assert.Equal("Normal Path Name", result);
        }
    }
}
