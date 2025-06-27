using System.Collections.Generic;
using System.IO;
using UniversalDownloaderPlatform.Common.Interfaces.Models;
using UniversalDownloaderPlatform.Common.Helpers;

namespace PatreonDownloader.Implementation
{
    public class PatreonCrawlTargetInfo : ICrawlTargetInfo
    {
        public long Id { get; set; }
        public string AvatarUrl { get; set; }
        public string CoverUrl { get; set; }

        private string _name;
        public string Name
        {
            get => _name;
            set
            {
                _name = value;
                // Use the comprehensive PathSanitizer for all sanitization
                _saveDirectory = PathSanitizer.SanitizePath(_name);
            }
        }

        private string _saveDirectory;
        public string SaveDirectory => _saveDirectory;
    }
}
