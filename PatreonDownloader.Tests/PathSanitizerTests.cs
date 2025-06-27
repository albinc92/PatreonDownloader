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

        [Fact]
        public void SanitizePath_WindowsReservedName_IsPrefixedWithUnderscore()
        {
            string result = PathSanitizer.SanitizePath("CON");
            
            Assert.Equal("_CON", result);
        }

        [Fact]
        public void SanitizePath_WindowsReservedNameWithExtension_IsPrefixedWithUnderscore()
        {
            string result = PathSanitizer.SanitizePath("PRN.txt");
            
            Assert.Equal("_PRN.txt", result);
        }

        [Fact]
        public void SanitizePath_ControlCharacters_AreReplacedWithUnderscore()
        {
            string result = PathSanitizer.SanitizePath("Test\x01\x02Name");
            
            Assert.Equal("Test__Name", result);
        }

        [Fact]
        public void SanitizePath_VeryLongPath_IsTruncated()
        {
            string longPath = new string('a', 300);
            string result = PathSanitizer.SanitizePath(longPath);
            
            Assert.True(result.Length <= 255, "Path should be truncated to 255 characters or less");
            Assert.True(result.EndsWith("..."), "Truncated path should end with ...");
        }

        [Fact]
        public void SanitizePath_ComplexInvalidName_IsFullySanitized()
        {
            string result = PathSanitizer.SanitizePath("COM1<>Test|User? ");
            
            Assert.Equal("_COM1__Test_User_", result);
        }

        [Fact]
        public void SanitizePath_StartsWithDot_IsPrefixedWithUnderscore()
        {
            string result = PathSanitizer.SanitizePath(".hidden");
            
            Assert.Equal("_.hidden", result);
        }

        [Fact]
        public void SanitizePath_OnlyDot_ReturnsUnknown()
        {
            string result = PathSanitizer.SanitizePath(".");
            
            Assert.Equal("Unknown", result);
        }
    }
}
