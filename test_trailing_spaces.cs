using System;
using System.IO;
using PatreonDownloader.Implementation;
using UniversalDownloaderPlatform.Common.Helpers;

class Program
{
    static void Main()
    {
        Console.WriteLine("Testing trailing space handling...");
        
        // Test PathSanitizer
        string testPath1 = "Princess Jasmine ";
        string sanitized1 = PathSanitizer.SanitizePath(testPath1);
        Console.WriteLine($"PathSanitizer: '{testPath1}' -> '{sanitized1}'");
        
        string testPath2 = "Test User . ";
        string sanitized2 = PathSanitizer.SanitizePath(testPath2);
        Console.WriteLine($"PathSanitizer: '{testPath2}' -> '{sanitized2}'");
        
        // Test PatreonCrawlTargetInfo
        var targetInfo = new PatreonCrawlTargetInfo();
        targetInfo.Name = "Princess Jasmine ";
        Console.WriteLine($"PatreonCrawlTargetInfo: 'Princess Jasmine ' -> '{targetInfo.SaveDirectory}'");
        
        targetInfo.Name = "Test User . ";
        Console.WriteLine($"PatreonCrawlTargetInfo: 'Test User . ' -> '{targetInfo.SaveDirectory}'");
        
        // Test edge cases
        targetInfo.Name = "   ";
        Console.WriteLine($"PatreonCrawlTargetInfo: '   ' -> '{targetInfo.SaveDirectory}'");
        
        string sanitized3 = PathSanitizer.SanitizePath("...");
        Console.WriteLine($"PathSanitizer: '...' -> '{sanitized3}'");
        
        // Test Windows reserved names
        string sanitized4 = PathSanitizer.SanitizePath("CON");
        Console.WriteLine($"PathSanitizer: 'CON' -> '{sanitized4}'");
        
        // Test complex invalid characters
        string sanitized5 = PathSanitizer.SanitizePath("Test<>User|Name? ");
        Console.WriteLine($"PathSanitizer: 'Test<>User|Name? ' -> '{sanitized5}'");
        
        // Test control characters
        string sanitized6 = PathSanitizer.SanitizePath("Test\x01\x02Name");
        Console.WriteLine($"PathSanitizer: 'Test\\x01\\x02Name' -> '{sanitized6}'");
        
        Console.WriteLine("Tests completed!");
    }
}
